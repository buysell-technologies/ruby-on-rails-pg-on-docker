require 'rails_helper'

RSpec.describe Task, type: :model do
  it"タイトルと内容がある場合、有効" do
    task = Task.new(
      title: "家事",
      description: "キッチン"
    )
    expect(task).to be_valid
  end

  it"タイトルがない場合、無効" do
    task = Task.new(
      title: nil,
      description: "キッチン"
    )
    task.valid?
    expect(task).to_not be_valid
  end

  describe 'タイトルの文字数' do
    context 'タイトルが30文字以内場合' do
      it"有効" do
        task = Task.new(
          title: "s" * 30,
          description: "キッチン"
        )
        expect(task).to be_valid
      end
    end

    context 'タイトルが30文字以上の場合' do
      it "無効" do
        task = Task.new(
          title: "s" * 31,
          description: "キッチン"
        )
        expect(task).to_not be_valid
      end
    end
  end

  it"内容がない場合、無効" do
    task = Task.new(
      title: "家事",
      description: nil
    )
    task.valid?
    expect(task).to_not be_valid
  end
  
end
