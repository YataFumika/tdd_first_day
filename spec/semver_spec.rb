require_relative "../lib/semver"

describe "Semver" do

  describe "major, minor, patch 番号を与えてバージョンオブジェクトを作成" do
    it "1,2,3 を与えてバージョンオブジェクトを作成" do
      expect(Semver.new(1, 2, 3)).to be_a(Semver)
    end
  end

  describe "バージョンオブジェクトの文字列表現を取得" do
    it "1,2,3のバージョンオブジェクトでversionメソッドで'1.2.3'を取得する" do
      semver = Semver.new 1, 2, 3
      expect(semver.version).to eq  "1.2.3"
    end

    it "1,4,2のバージョンオブジェクトでversionメソッドで'1.4.2'を取得する" do
      semver = Semver.new 1, 4, 2
      expect(semver.version).to eq  "1.4.2"
    end
  end

  describe "あるバージョンオブジェクトが、他のバージョンオブジェクトと等しいかどうかを判定する" do
    it "バージョン 1.4.2 は バージョン 2.1.0 と等しくない" do
      semver1 = Semver.new 1, 4, 2
      semver2 = Semver.new 2, 1, 0
      expect(semver1.equal semver2).to eq false
    end
    it "バージョン 1.4.2 は バージョン 1.4.2 と等しい" do
      semver1 = Semver.new 1, 4, 2
      semver2 = Semver.new 1, 4, 2
      expect(semver1.equal semver2).to eq true
    end
  end

  describe "major, minor, patch フィールドはゼロ、または正の整数。それ以外のものが与えられたら例外が発生" do

    it "バージョンオブジェクト生成時に major, minor, patch に 0 を与えると例外が発生しない" do
      expect { Semver.new 0, 0, 0 }.not_to raise_error
    end

    it "バージョンオブジェクト生成時に major, minor, patch に 1 を与えると例外が発生しない" do
      expect { Semver.new 1, 1, 1 }.not_to raise_error
    end

    it "バージョンオブジェクト生成時に major, minor, patch に -1 を与えると例外が発生する" do
      expect { Semver.new -1, -1, -1 }.to raise_error(ArgumentError)
    end
  end
end