text_check="This website is temporarily busy and is having difficulties loading the page" #アクセス集中ページに接続した時に出る文章の一部

roop=20000  #アクセス回数
i=0 #今までに何回購入ページにアクセスしたか
while [ $i -lt $roop ] #doからdoneまでroop回繰り返し行う
do
    open -ga Safari https://reserve.tokyodisneyresort.jp/ticket/search/  #Safariでディズニーチケット購入ページに接続
    sleep 0.4 #サイトに文章が表示されるまで0.4秒待機
    text=`osascript -e 'tell app "Safari" to get the text of the current tab of window 1'` #接続したサイトに表示される文章を取得
    while [ -z "$text" ] #何の文章も取得できなかった場合に以下のdo~doneを繰り返す
     do
        sleep 0.1 #0.1秒待機
        text=`osascript -e 'tell app "Safari" to get the text of the current tab of window 1'` #サイトの文章を再取得
     done
    echo "$text" | grep -q "$text_check" #接続したサイトに表示される文章に"this website ~"が含まれるか調べる
    if [ $? -eq 0 ]  ; then #アクセス集中ページに接続したかの判別
        i=$(( i + 1 )) #(アクセス集中ページに接続した場合)今までのアクセス回数を1増やす
    else #一つ下と二つ下の行が購入ページなどアクセス集中ページ以外に接続した場合
	echo $i 回目のアクセスで成功 #アクセスに成功したことを表示
	break #ループを終わらせる
    fi
done

