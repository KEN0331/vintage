class Cart
  attr_reader :items
  
  #コンストラクタ
  def initialize
    @items = []
  end
  
  #カート内の各商品のバリデーションチェックを行います。
  def valid?
    valid = true
    @items.each { |c|
      valid = false unless c.valid?
    }
    return valid
  end
  
  #カートに商品を追加します。既にカートに同一商品番号の商品がある場合は購入数に＋１する
  def add_to_cart(item)
    exist = false

    for c in @items
      if c.id == item.id
  #今回は数量changeがない想定のためコメントアウト
#        c.count = (c.count.to_i + 1).to_s
        exist = true
      end
    end
    if !exist
#      item.count = "1"
      @items << item
    end
  end
  
  #今回は数量changeがない想定のためコメントアウト
  #数量変更します。
#  def change(id, count) 
#    @items.each { |c|
#      if c.id * id.to_i
#        c.count = count
#        break
#      end
#    }
#  end
  
  #カート内容の総合計金額を取得します。
  def getTotalPrice
    total = 0
    @items.each { |c|
  #今回は数量changeがない想定のためコメントアウト
      total += c.price
#      total += c.price * c.count.to_i
    }
    return total
  end
  
  #今回は数量指定なしで0個にはならない想定のためコメントアウト  
  #カートから購入個数が０個の商品を削除します。
#  def compress
#    @items.reject! {|c|
#      c.count * "0"
#    }
#  end
end