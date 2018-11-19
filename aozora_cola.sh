#!/bin/sh

export BERT_BASE_DIR=`pwd`/multilingual_L-12_H-768_A-12
export GLUE_DIR=`pwd`/aozora
export PYTHONPATH=`pwd`/bert

BIN_PYTHON=python
EPOCH=3
NO_CHKPT=0
while getopts e:p:ns opts ; do
    case $opts in
	e)
	    EPOCH=$OPTARG
	    ;;
	p)
	    BIN_PYTHON=$OPTARG
	    ;;
	n)
	    NO_CHKPT=1
	    ;;
	s)
	    export GLUE_DIR=`pwd`/aozora/small
	    ;;
    esac
done
OUTPUT_PATH=aozora/cola_${EPOCH}_output

if [ $NO_CHKPT -eq 0 ] ; then
    $BIN_PYTHON bert/run_classifier.py \
		--task_name=cola \
		--do_train=true \
		--do_eval=true \
		--data_dir=$GLUE_DIR \
		--vocab_file=$BERT_BASE_DIR/vocab.txt \
		--bert_config_file=$BERT_BASE_DIR/bert_config.json \
		--init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
		--max_seq_length=128 \
		--train_batch_size=32 \
		--learning_rate=2e-5 \
		--num_train_epochs=$EPOCH \
		--output_dir=$OUTPUT_PATH
else
    OUTPUT_PATH=${OUTPUT_PATH}_nockpt
    $BIN_PYTHON bert/run_classifier.py \
		--task_name=cola \
		--do_train=true \
		--do_eval=true \
		--data_dir=$GLUE_DIR \
		--vocab_file=$BERT_BASE_DIR/vocab.txt \
		--bert_config_file=$BERT_BASE_DIR/bert_config.json \
		--max_seq_length=128 \
		--train_batch_size=32 \
		--learning_rate=2e-5 \
		--num_train_epochs=$EPOCH \
		--output_dir=$OUTPUT_PATH
fi
