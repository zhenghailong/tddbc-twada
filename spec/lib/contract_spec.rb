require 'date'
describe Contract do
  let(:contract) { Contract.new }
  let(:signed_on) { '2021-01-25' }

  describe "#sign" do
    before { contract.sign(product, signed_on) }

    context "ワードプロセッサ「MS Word」１つ購入" do
      context "契約日に直ちに売上全額を収益認識する" do
        let(:product) { WordProcessor.new('MS Word', 18800) }


        it '売上全額が18800円' do
          expect(contract.revenue).to eq 18800
        end

        it '収益認識がが18800円' do
          expect(contract.revenue_recognition.revenue).to eq 18800
        end

        it '売上金額と収益認識の総和が同額' do
          expect(contract.revenue_recognition(signed_on).revenue).to eq contract.revenue
        end
      end
    end

    context "スプレッドシート「MS Excel」１つ購入" do
      context "契約日に売上の2/3、30日後に1/3を収益認識する" do
        let(:product) { SpreadSheet.new('MS Excel', 27800) }

        it '売上全額が27800円' do
          expect(contract.revenue).to eq 27800
        end

        it "契約日に売上の2/3を収益認識する" do
          expect(contract.revenue_recognition(signed_on).revenue).to eq (27800*2 / 3) + 1
        end

        it "契約日の30日後にの1/3を収益認識する" do
          expect(contract.revenue_recognition('2021-02-24').revenue).to eq 27800 / 3
        end

        it '売上金額と収益認識の総和が同額' do
          sum_revenue_recognitions = contract.all_revenue_recognitions.sum(&:revenue)
          expect(sum_revenue_recognitions).to eq contract.revenue
        end
      end
    end

    context "データベース「MS SQL Server」１つ購入" do
      context "契約日に売上の1/3、60日後に1/3、120日後にまた1/3を収益認識する" do
        let(:product) { Database.new('MS SQL Server', 919000) }

        it '売上全額が919000円' do
          expect(contract.revenue).to eq 919000
        end

        it "契約日に売上の1/3を収益認識する" do
          expect(contract.revenue_recognition(signed_on).revenue).to eq (919000 / 3) + 1
        end

        it "契約日の60日後にの1/3を収益認識する" do
          expect(contract.revenue_recognition('2021-03-26').revenue).to eq 919000 / 3
        end

        it "契約日の120日後にの1/3を収益認識する" do
          expect(contract.revenue_recognition('2021-05-25').revenue).to eq 919000 / 3
        end

        it '売上金額と収益認識の総和が同額' do
          sum_revenue_recognitions = contract.all_revenue_recognitions.sum(&:revenue)
          expect(sum_revenue_recognitions).to eq contract.revenue
        end
      end
    end
  end
end