$text_check="This website is temporarily busy and is Having difficulties loading the page"	 #アクセス集中ページに接続したときにで出る文章の一部
$url="https://reserve.tokyodisneyresort.jp/ticket/search/"	#チケット購入ページのURL
$browser = New-Object -ComObject InternetExplorer.Application	#InternetExplorerを開く
$browser.Visible=$true	#ブラウザを開く

$roop=20000	#アクセス回数
$i=0	#今までに何回アクセスしたか
while($i -lt $roop){	#以下のプロセスをroop回繰り返す
	$browser.Navigate($url)	#購入ページに接続
	while($browser.Busy){Start-Sleep -m 400}	#何らかのサイトに繋がるまで0.4×n秒待つ
	$text=$browser.Document.body.innerText	#ブラウザに表示された文章を取得
	if($text -eq $null){	#文章の取得に成功したか確認
		echo "Failure!!"	#失敗した場合に"Failure!!"と表示
		break	#（失敗した場合）プロセスを終了
	}else{	#文章の取得に成功した場合以下を実行
		if($text.Contains($text_check)){	#取得した文章に"This website is..."が含まれるか調べる
			$i++	#含まれていた場合次のアクセスをトライ
		}else{	#含まれなかった場合アクセス成功とみなす
			echo "Suceed!! Access Number: $i"	#成功した旨を表示
			break	#プロセスを終了
		}
	}
}

