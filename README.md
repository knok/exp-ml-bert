<!-- -*- coding: utf-8 -*- -->
# BERT多言語モデルの二値分類評価

## このリポジトリについて

Google Researchが公開している[BERT](https://github.com/google-research/bert)の[日本語を含んだ多言語モデル](https://github.com/google-research/bert/blob/master/multilingual.md)にて、日本語で記述されたテキストの二値分類を評価してみた結果と、それを再現するスクリプト群を公開しています。

## 下準備

[0-setup.ipynb](https://github.com/knok/exp-ml-bert/blob/master/0-setup.ipynb)を実行すると、ライブドアニュースコーパスを取得し、[GLUE Benchmark](https://gluebenchmark.com/tasks)の[The Corpus of Linguistic Acceptability (CoLA)](https://nyu-mll.github.io/CoLA/)と同じ構造のtsvファイルを生成します。
コーパスは9カテゴリのニュースから構成されていますが、そのうち[「ITライフハック」](http://news.livedoor.com/category/vender/223/)と[「家電チャンネル」](http://news.livedoor.com/category/vender/kadench/)の記事のタイトル(本文ファイルの3行目)のみを用います。記事数は全部で1734本となります。

### Sports WatchとPeachyを用いたデータセット

前述の処理を実行した状態で[0.1-setup.ipynb](https://github.com/knok/exp-ml-bert/blob/master/0.1-setup.ipyanb)を実行すると、サブディレクトリswpが作成され、そこに「Sports Watch」と「Peachy」の記事タイトルを集めたデータセットが用意されます。

### 青空文庫を用いたデータセット

[青空文庫](https://www.aozora.gr.jp/)から、芥川龍之介と宮沢賢治の著作を収集し、ある程度の長さの本文を下処理した結果を[aozora](aozora)ディレクトリ以下に用意してあります。
元となったデータへのURL一覧と、データの下処理を行うスクリプトも参考用として用意してあります。

## 訓練と評価

[run_cola.sh](https://github.com/knok/exp-ml-bert/blob/master/run_cola.sh)を実行することで、ライブドアニュースコーパスデータ全体の8割を訓練データとしてCoLAタスクを訓練として実行し、1割の評価データにてモデルのaccuracyを評価します。
このスクリプトは以下のオプションを指定できます。

* -e ###: 訓練エポック数
* -p /path/to/python: 呼び出すpythonのパス

[1-classifier-eval.ipynb](https://github.com/knok/exp-ml-bert/blob/master/1-classifier-eval.ipynb)にて、実際にepoch数10, 30, 3で実行した結果を残しています。

### Sports WatchとPeachyでの訓練

前述で説明したスクリプトに以下のオプションを追加することで、swp以下にあるデータを用いた訓練と評価を行うことができます。

* -s : ./swp 以下のtsvを参照し、結果も ./swp 以下に保存する

これを用いて訓練、評価した結果を[1.1-classifier-eval.ipynb](1.1-classifier-eval.ipynb)に残しています。

## 事前学習モデルを用いない(転移学習を行わない)場合

run_cola.shに-nを指定すると、事前学習モデルを読み込まないで訓練、評価を行います。結果は以下に残しています。

* [2-classifier-without-cp.ipynb](2-classifier-without-cp.ipynb)


### scikit-learnを用いた分類器の訓練

sklearnのTfidfVectorizerとMultinominalNBを使った分類器での評価結果を比較用に追加してあります。BERTのトークナイザを用いています。

* [5-tfidf-classification.ipynb](5-tfidf-classification.ipynb)
* [6-tfidf-classify-other-data.ipynb](6-tfidf-classify-other-data.ipynb)

## 参考

* [BERTの学習済みモデルを使ってみる | NHN テコラス Tech Blog | AWS、機械学習、IoTなどの技術ブログ](https://techblog.nhn-techorus.com/archives/12978)

## License

[Apache 2.0](LICENCE)