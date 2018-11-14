<!-- -*- coding: utf-8 -*- -->
# BERT多言語モデルの二値分類評価

## このリポジトリについて

Google Researchが公開している[BERT](https://github.com/google-research/bert)の[日本語を含んだ多言語モデル](https://github.com/google-research/bert/blob/master/multilingual.md)にて、日本語で記述されたテキストの二値分類を評価してみた結果と、それを再現するスクリプト群を公開しています。

## 下準備

[0-setup.ipynb](https://github.com/knok/exp-ml-bert/blob/master/0-setup.ipynb)を実行すると、ライブドアニュースコーパスを取得し、[GLUE Benchmark](https://gluebenchmark.com/tasks)の[The Corpus of Linguistic Acceptability (CoLA)](https://nyu-mll.github.io/CoLA/)と同じ構造のtsvファイルを生成します。
コーパスは9カテゴリのニュースから構成されていますが、そのうち(「ITライフハック」)[http://news.livedoor.com/category/vender/223/]と(「家電チャンネル」)[http://news.livedoor.com/category/vender/kadench/]の記事のタイトル(本文ファイルの3行目)のみを用います。記事数は全部で1734本となります。

## 訓練と評価

(run_cola.sh)[https://github.com/knok/exp-ml-bert/blob/master/run_cola.sh]を実行することで、データ全体の8割を訓練データとしてCoLAタスクを訓練として実行し、1割の評価データにてモデルのaccuracyを評価します。
このスクリプトは以下のオプションを指定できます。

* -e ###: 訓練エポック数
* -p /path/to/python: 呼び出すpythonのパス

(1-classifier-eval.ipynb)[https://github.com/knok/exp-ml-bert/blob/master/1-classifier-eval.ipynb]にて、実際にepoch数10, 30, 3で実行した結果を残しています。

## TODO

* 他のモデルとの比較
  * 非transformer系

## 参考

* [BERTの学習済みモデルを使ってみる | NHN テコラス Tech Blog | AWS、機械学習、IoTなどの技術ブログ](https://techblog.nhn-techorus.com/archives/12978)

## License

[Apache 2.0](LICENCE)