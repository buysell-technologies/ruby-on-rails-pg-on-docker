require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task){ FactoryBot.build(:task) }
  
  describe 'バリデーション' do
    it 'タイトルと内容がある場合、有効' do
      expect(task).to be_valid
    end
  
    it 'タイトルがない場合、無効' do
      task.title = ''
      expect(task).to_not be_valid
    end
  
    describe 'タイトルの文字数' do
      context 'タイトルが30文字以内場合' do
        it '有効' do
          expect(task).to be_valid
        end
      end
  
      context 'タイトルが30文字以上の場合' do
        it '無効' do
          task.title = "s" * 31
          expect(task).to_not be_valid
        end
      end
    end
  
    it '内容がない場合、無効' do
      task.description = ''
      expect(task).to_not be_valid
    end
  end

  
  let(:second_task){ FactoryBot.build(:second_task) }
  describe '検索' do    
    describe 'タイトル' do
      subject { Task.find_by(title: title) }

      context '掃除というタスクを検索' do
        before do
          task = create(:task)
        end
        let(:title) { '掃除' }
        it { is_expected.to eq task }
      end
      context 'カリキュラムというタスクを検索' do
        let(:title) { 'カリキュラム' }
        it { is_expected.to eq nil }
      end
    end

    describe 'ステータス' do
      subject { Task.find_by(status: status) }

      context '未着手を検索' do
        before do
          second_task = create(:second_task)
        end
        let(:status) { '未着手' }
        it { is_expected.to eq second_task }
      end
      context '作業中を検索' do
        let(:status) { '作業中' }
        it { is_expected.to eq nil }
      end
    end
  end
end
