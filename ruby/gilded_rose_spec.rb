require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "does not allow quality to degrade below 0" do
      items = [Item.new("foo", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "degrades quality by one per update for normal items" do
      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end

    it "quality degrades by two per update for normal items with a SellIn of 0" do
      items = [Item.new("foo", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 8
    end

    it "quality of Aged Brie increases when updated" do
      items = [Item.new("Aged Brie", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 11
    end

    it "quality of Aged Brie increases by two when SellIn is 0" do
      items = [Item.new("Aged Brie", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "quality of Aged Brie cannot exceed 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it "does not change quality of legendary items" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "increases quality of backstage passes if SellIn over 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 11
    end

    it "increases quality of backstage passes by 2 if SellIn under 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "increases quality of backstage passes by 3 if SellIn under 5" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it "decreases quality of backstage passes to 0 if SellIn is 0" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe "#normal_update" do
    it "degrades quality by 1 per update" do
      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).normal_update()
      expect(items[0].quality).to eq 9
    end

    it "decreases sell_in by 1 per update" do
      items = [Item.new("foo", 5, 10)]
      GildedRose.new(items).normal_update()
      expect(items[0].sell_in).to eq 4
    end

    it "does not decrease quality below 0" do
      items = [Item.new("foo", 5, 0)]
      GildedRose.new(items).normal_update()
      expect(items[0].quality).to eq 0
    end
  end

end
