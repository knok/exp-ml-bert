#!/bin/sh

export BERT_BASE_DIR=`pwd`/multilingual_L-12_H-768_A-12
export GLUE_DIR=`pwd`
export PYTHONPATH=`pwd`/bert

BIN_PYTHON=python
OUTPUT_PATH=out
TRAINED_CLASSIFIER=cola_3_output
CHECK
while getopts p:t:o: opts ; do
    case $opts in
	p)
	    BIN_PYTHON=$OPTARG
	    ;;
	t)
	    TRAINED_CLASSIFIER=$OPTARG
	    ;;
	o)
	    OUTPUT_PATH=$OPTARG
	    ;;
    esac
done

$BIN_PYTHON bert/run_classifier.py \
	    --task_name=cola \
	    --do_predict=true \
	    --data_dir=$GLUE_DIR \
	    --vocab_file=$BERT_BASE_DIR/vocab.txt \
	    --bert_config_file=$BERT_BASE_DIR/bert_config.json \
	    --init_checkpoint=$TRAINED_CLASSIFIER \
	    --max_seq_length=128 \
	    --output_dir=$OUTPUT_PATH
