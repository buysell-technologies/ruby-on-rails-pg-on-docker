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
end
