require_relative "../lib/semver"

describe "バージョンオブジェクト" do

  describe "major, minor, patch 番号を与えてバージョンオブジェクトを作成" do
    it "1,2,3 を与えてバージョンオブジェクトを作成" do
      expect(Semver.new(1, 2, 3)).to be_a(Semver)
    end
  end

  describe "バージョンオブジェクトの文字列表現を取得" do
    it "major=1,minor=2,patch=3のバージョンオブジェクトのバージョン文字列'1.2.3'を返す" do
      semver = Semver.new 1, 2, 3
      expect(semver.to_s).to eq  "1.2.3"
    end

    it "major=1,minor=4,patch=2のバージョンオブジェクトのバージョン文字列'1.4.2'を返す" do
      semver = Semver.new 1, 4, 2
      expect(semver.to_s).to eq  "1.4.2"
    end
  end

  describe "あるバージョンオブジェクトが、他のバージョンオブジェクトと等しいかどうかを判定する" do
    it "バージョン 1.4.2 は バージョン 2.1.0 と等しくない" do
      semver1 = Semver.new 1, 4, 2
      semver2 = Semver.new 2, 1, 0
      expect(semver1 == semver2).to be_falsey
    end
    it "バージョン 1.4.2 は バージョン 1.4.2 と等しい" do
      semver1 = Semver.new 1, 4, 2
      semver2 = Semver.new 1, 4, 2
      expect(semver1 == semver2).to be_truthy
    end
  end

  describe "major, minor, patch フィールドはゼロ、または正の整数。それ以外のものが与えられたら例外が発生" do
    describe "major, minor, patch フィールドはゼロ、または正の整数" do
      it "バージョンオブジェクト生成時に major, minor, patch に 0 を与えると例外が発生しない" do
        expect { Semver.new 0, 0, 0 }.not_to raise_error
      end

      it "バージョンオブジェクト生成時に major, minor, patch に 1 を与えると例外が発生しない" do
        expect { Semver.new 1, 1, 1 }.not_to raise_error
      end
    end

    describe "それ以外のものが与えられたら例外が発生" do
      it "バージョンオブジェクト生成時に major, minor, patch に -1 を与えると例外が発生する" do
        expect { Semver.new -1, -1, -1 }.to raise_error(ArgumentError)
      end

      it "バージョンオブジェクト生成時に major, minor, patch に 1.5 を与えると例外が発生する" do
        expect { Semver.new 1.5, 1.5, 1.5 }.to raise_error(ArgumentError)
      end

      it " バージョンオブジェクト生成時に major, minor, patch に 文字列 'a', 'b', 'c'を与えると例外が発生する" do
        expect { Semver.new 'a', 'b', 'c' }.to raise_error(ArgumentError)
      end
    end
  end

  describe "semver におけるバージョンアップルール" do
    describe " パッチバージョンアップすると、patchフィールドをインクリメントする" do
      it "バージョン 1.2.3 はバージョン 1.2.4 になる" do
        semver = Semver.new 1, 2, 3
        expect(semver.update_patch.to_s).to eq "1.2.4"
      end

      it "バージョン 1.2.9 はバージョン 1.2.10 になる" do
        semver = Semver.new 1, 2, 9
        expect(semver.update_patch.to_s).to eq "1.2.10"
      end
    end

    describe "マイナーバージョンアップすると、 minor フィールドをインクリメントし、 patch フィールドを 0 にする" do
      it "バージョン 1.2.3 はバージョン 1.3.0 になる" do
        semver = Semver.new 1, 2, 3
        expect(semver.update_minor.to_s).to eq "1.3.0"
      end

      it "バージョン 1.9.0 はバージョン 1.10.0 になる" do
        semver = Semver.new 1, 9, 0
        expect(semver.update_minor.to_s).to eq "1.10.0"
      end
    end

    describe "メジャーバージョンアップすると、major フィールドをインクリメントし、 minor, および patch フィールドを 0 にする" do
      it "バージョン 1.2.3 はバージョン 2.0.0 になる" do
        semver = Semver.new 1, 2, 3
        expect(semver.update_major.to_s).to eq "2.0.0"
      end

      it "バージョン 1.0.0 はバージョン 2.0.0 になる" do
        semver = Semver.new 1, 0, 0
        expect(semver.update_major.to_s).to eq "2.0.0"
      end
    end
  end
end