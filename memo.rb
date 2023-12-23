require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

# if文を使用して続きを作成していきましょう。
# 「memo_type」の値（1 or 2）によって処理を分岐させていきましょう。

puts "拡張子を除いたファイルを入力してください"
    title = gets.chomp
    file_path = "./#{title}.csv"


if memo_type == 1
    
    puts "メモしたい内容を記入してください"
    puts "完了したらctrl+Dを押します"
    lines = $stdin.readlines.map(&:chomp) # 改行文字を削除して配列を作成（配列の要素一つ一つにメソッドを与える）

    File.open(file_path, "w") do |file|
        lines.each do |line|
            file.puts line
        end
    end
elsif memo_type == 2
    
    lines = File.readlines(file_path)

    count = 0 #lines.eachのカウント用

    lines.each do |line|
        count += 1
        puts "#{count}行目：#{line}" 
    end

    select = "y" # はいの場合編集を続ける
    # 行の置換
    while select == "y"
        puts "行番号を入力して下さい"
        i = gets.to_i
        puts "変更内容を入力してください"
        lines[i-1] = gets.chomp # 1行目を 入力値 に変更
        #表示内容の確認
        count = 0
        lines.each do |line|
            count += 1
            puts "#{count}行目：#{line}"
        end

        while true # ここでwhileにしないと上のwhileに戻ってしまう
            puts "他の行も変更しますか？（はい=>y, いいえ=>n）"
            select = $stdin.gets.chomp
            if select == "y"
                
                break
            elsif select == "n"
                
                break
            else
                puts "無効な入力です。yかnを選んでください"
                #表示内容の確認
                count = 0
                lines.each do |line|
                    count += 1
                    puts "#{count}行目：#{line}"
                end
            end
        end
    end

    # ファイルを書き込む（上書き）
    File.open(file_path, "w") do |file|
    file.puts lines # 変更した内容をファイルに書き込む
    end
end

