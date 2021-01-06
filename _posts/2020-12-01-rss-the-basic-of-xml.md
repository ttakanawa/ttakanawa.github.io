---
layout: post
title: "RSS with XML"
tags: [rss,xml]
image: /assets/img/rss.jpg
cc: {url: 'https://flic.kr/p/r4VzkT', author: Alan Levine}
---

2021年から始める RSS をテーマに書いていきます。リアルタイムで RSS の隆盛を追っていなかった僕を含むウェブエンジニアが、本投稿を読むことで RSS に関する煩わしさを乗り越えてさらには魅力を感じるきっかけが見つけられたらいいなと思います。
目的がこの通りですので RSS の詳細な仕様には触れない予定です。最後の一文まで読んだからといって各 RSS エレメントの使い方がわかるようにはならないです。

また、ウェブエンジニア以外の方におかれましては、衰退していく RSS 配信を実装するメリットなど無いと考えておられるかもしれませんが、RSS 配信を充実させることによってそのウェブサイトを多くの人に知ってもらうための発火装置のような仕掛けを設置していくことができます。
これは SEO 対策とはニュアンスが違いますが、同じくらい、あるいはサイトの性質によってはそれ以上に重視されるべきアプローチだと思います。
RSS 配信の実装は地味な作業ですし、すぐには成果が分かりづらい領域ですが、この投稿は より俯瞰して RSS をはじめとする技術を知ることによってお客さんに新たな提案ができることを目指す内容も含みます。

## ロードマップ

4つに分けて進めていきたいと思います。

- **XML の基本的なこと**

最も基本的な前提として、 RSS は XML (Extensible Markup Language) です。そのため、その先の内容をより理解するために XML の基本的なことをさらっておきます。

- **RSS の基本的なこと**

RSS には2つの系統があります。 1.0 と 2.0 です。混乱のもとに生まれたこの2つの系統はのちに Atom が誕生したことにも繋がってきますが、歴史的なことを追うつもりはなく、あくまで実用的な内容をまとめていきます。

- **RSS と Atom の違い。何が不満で Atom は誕生したのか、その具体的なシーンを考える。**

RSS と Atom は使われ方としてとても似ています。 Atom が誕生し、 Gmail が Atom 形式でメールを取得できるようにしていることから Atom の存在は無視できないです。一体 RSS の何が問題で Atom はどのような点が優れているのか。この全く searchable でない "Atom" について RSS との比較を通して理解を深めていきます。 

- **我々に求められる取捨選択。RSS 1.0, RSS 2.0, Atom、どのフォーマットに対応すべきか、何を基準に考えるのか。**

iPhone が expensive だなんて感じたことがない Apple 信者、プライバシーな情報でも全て捧げます Google 信者、 PC の設定を絶対にカスタマイズするゴリゴリカスタマイズ教と不便に感じていても絶対に変更しない頑固デフォルト教など、テック業界には様々な信条・宗教がありますが RSS 周りもまた同じかもしれません。ですので、ここではあくまで僕の個人的な考えをまとめたいと思います。
ちなみに僕はPCもスマホもデフォルトで使いたいデフォルト教です。

## XML の基本的なこと

XML は Extensible Markup Language のことで、 Extensible （拡張性）についてはこの後具体的に説明していきますが、 Markup Language （マークアップ言語）については特に説明しません。
ですのでここで簡単に確認しておきますと、タグで囲む（マークをつける）ことで構造を表現する言語のことです。みなさんが毎日見ている HTML もその1つです。

そして現在、 XML には XML 1.0 と XML 1.1 の2つのバージョンがあり、XML 1.0 がデファクトスタンダードです。

> XML 1.0 は、多くの処理系が実装され、現在においても一般的な用途に対しては採用が勧められるとされている。
>
> [Extensible Markup Language - Wikipedia](https://ja.wikipedia.org/wiki/Extensible_Markup_Language#%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3)

RSS もやはり多くの場合は XML 1.0 を使っています。中には XML 1.1 を使っている RSS もあるのかもしれませんが、今回は RSS がメインテーマですので XML のバージョン間の違いについては特に言及しません。 XML 1.0 を使うものとして話を進めます。
もし XML 1.1 を使うことでこのあとの RSS の説明が変わるようなことがあれば内容を修正したいと思います。

では、メインテーマの RSS から大きく逸れたくないので早速 Extensible （拡張性）について触れたいと思います。

```
<?xml version="1.0" encoding="UTF-8"?>
```

そして名前のごとく Extensible である技術はいくつがあるが、ここで取り上げるのは名前空間です。XML は名前空間によって拡張することができるのです。

一応列挙すると以下のような技術によって XML は Extensible なのです。

- XML Path Language (XPath)
- XML Inclusions (XInclude)
- XQuery
- XML名前空間 (Namespaces in XML)
- XML Signature
- XML Encryption
- XML Pointer Language (XPointer)

では名前空間が RSS でどのように使われているのか、実際の RSS ファイルを参考に調べていきたいと思います。

## RSS でよく見る xmlns ってなに？

以下は僕がよく聴くPodcastの RSS を一部抜粋したものです。RSSとして一般的な内容かつ特定される内容に関してはマスクしますので掲載して問題ないと思います。

```
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:dc="http://purl.org/dc/elements/1.1/">
...(中略)
</rss>
```

このように xmlns: から始まる属性をいくつか記述しています。そしてこれらは下記のように使われています。
（ここでは使われているという表現をしましたが、現段階ではまだ「何らかの関係性を持っている」という表現の方が良いかもしれません。）

```
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <channel>
    <atom:link href="https://xxxxx" rel="self" type="application/rss+xml" /> // ここ
    <itunes:category text="Technology"/>                                     // ここ
    <media:thumbnail url="https://xxxxx.png" />                              // ここ
...（以下略）
```

さて、まずこの xmlns: から始まる属性は XML で名前空間を宣言する際に用います。以下の引用がわかりやすいです。

> スキーマaとスキーマbの2つのスキーマに基づいたXML文書を考えます。 スキーマが2つあるということは、 それぞれのスキーマで定義されている要素が1つの文書内に混在するということです。
>
> ここで、2つのスキーマの要素をそのまま使うことはできません。 どちらのスキーマの要素なのかを、なんらかの方法で明示しておく必要があります。 例えば、スキーマaでもスキーマbでもname要素があったとき、 そのままだと、どちらの要素なのか区別かつかなくなるからです。
>
> [XMLにおける名前空間 - データ記述とXML](https://www.mlab.im.dendai.ac.jp/~yamada/web/xml/namespace.html)

> 名前空間(name space)は XML に限らない一般的な概念で、 名前の有効な範囲を表します。 例えば「1号館」という名前は、 東京電機大学の東京千住キャンパスという名前空間に属しています。 その名前空間の外では、「1号館」は別の建物を表すかもしれません。
>
>  プログラミングの際、 1つのメソッド(あるいは関数)の中で同じ変数名を宣言することはできません。 これは、1つの名前空間の中に同じ名前をつくることはできないからです。
>
> [XMLにおける名前空間 - データ記述とXML](https://www.mlab.im.dendai.ac.jp/~yamada/web/xml/namespace.html)



つまり、上述の

```
xmlns:atom="http://www.w3.org/2005/Atom"
```

は、Atomの名前空間が http://www.w3.org/2005/Atom で、 これは長いのでまず atom という別名をつけるという記述です。そのあとの

```
<atom:link href="https://xxxxx" rel="self" type="application/rss+xml" />
```

という記述は、Atom によって定義された link という要素（エレメント）を使って情報を書いているわけですが、 RSS で定義される link エレメントとは違う役割の link ということが名前空間のおかげで明確になっています。

ちなみに具体的に Atom によって定義された link はどのように機能するのか見てみるとこのような役割があるそうです。

```
4.2.7.  The "atom:link" Element

   The "atom:link" element defines a reference from an entry or feed to
   a Web resource.  This specification assigns no meaning to the content
   (if any) of this element.

   atomLink =
      element atom:link {
         atomCommonAttributes,
         attribute href { atomUri },
         attribute rel { atomNCName | atomUri }?,
         attribute type { atomMediaType }?,
         attribute hreflang { atomLanguageTag }?,
         attribute title { text }?,
         attribute length { text }?,
         undefinedContent
      }
```

[RFC 4287 - The Atom Syndication Format](https://tools.ietf.org/html/rfc4287#section-4.2.7)より。

よりわかりやすい例は、上述の

```
xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
```
と
```
<itunes:category text="Technology"/>
```

です。

名前空間 http://www.itunes.com/dtds/podcast-1.0.dtd で定義されるところの category エレメントを使っていることがわかります。
前述の通りこれは僕が聴いている Podcast の RSS の抜粋なので、この itunes:category エレメントの記述はおそらくは Podcast をカテゴリ別に表示しているこのページ https://podcasts.apple.com/us/genre/podcasts/id26 などに影響を与えているのだろうと思います。
itunes:category に関する仕様は[こちら](https://help.apple.com/itc/podcasts_connect/#/itc9267a2f12)です。

こうして見ると、 RSS は名前空間を増やしていくことによってほぼ無限に拡張され得るドキュメントだと考えられます。



## RSS の基本的なこと

前回の「 XML の基本的なこと」で名前空間について書きました。
名前空間は RSS ではなく　XML の技術ですが RSS を使う上で重要になってくるし、実装する上で多くの場合無視できない技術ですので。


## RSS と Atom の違い。何が不満で Atom は誕生したのか、その具体的なシーンを考える。

そもそも RSS と Atom は、どちらもニュースやブログなど各種ウェブサイトの更新情報を配信するための文書フォーマットのこと。
歴史的には RSS が先行して登場し、 RSS の仕様が曖昧あることなどに不満をもった一部のユーザーが新しい規格として Atom を規定。
普及率としては RSS の方が高いらしいが、 Atom の支持者が多いのも事実。
また、多くの RSS バリデーター（そのXMLファイルが RSS として適切かどうかチェックするツール）では Atom に関連した要素（後述）をチェックしているため、 Atom を知ることは必至。

### Appendix

- マークアップ言語 (markup language)とは｜「分かりそう」で「分からない」でも「分かった」気になれるIT用語辞典
https://wa3.i-3-i.info/word1578.html

- XMLにおける名前空間 - データ記述とXML
https://www.mlab.im.dendai.ac.jp/~yamada/web/xml/namespace.html

- Adding Atom:Link to Your RSS Feed
https://workbench.cadenhead.org/news/3284/adding-atomlink-your-rss-feed

- Atom Syndication Format namespace
https://www.w3.org/2005/Atom

- RFC 4287 - The Atom Syndication Format
https://tools.ietf.org/html/rfc4287

- Apple Podcasts Categories - Podcasts
https://help.apple.com/itc/podcasts_connect/#/itc9267a2f12

- RSS - Wikipedia
https://ja.wikipedia.org/wiki/RSS#Atom
