require 'spechelper'

describe Task do
  it {should belong_to :list}
  it 'can return the not done tasks' do
    not_done_task = (1..2).to_a.map do |number|
      Task.create(:name => "task #{number}", :done => false)
    end
    done_task = Task.create(:name => 'done task', :done => true)
    Task.not_done.should eq not_done_task
  end
end
