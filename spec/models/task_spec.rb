require 'spec_helper'

describe Task do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :assigned }
    it { should validate_presence_of :reporter }
    it { should validate_presence_of :taskable }
    it { should validate_uniqueness_of :title }
  end

  describe "associations" do
    it { should belong_to :assigned }
    it { should belong_to :reporter }
    it { should belong_to :taskable }
  end

  it "should have status open for new task" do
    project = create(:project)
    user = create(:user)
    task = create(:task, taskable: project, reporter: user, assigned: user)

    expect(task.status).to be(Task::OPENED)
  end

  it "should set task as resolved when asking for it" do
    project = create(:project)
    user = create(:user)
    task = create(:task, taskable: project, reporter: user, assigned: user)

    task.resolve

    expect(task.status).to be(Task::RESOLVED)
  end

  it "should set task as closed when asking for it" do
    project = create(:project)
    user = create(:user)
    task = create(:task, taskable: project, reporter: user, assigned: user)

    task.close

    expect(task.status).to be(Task::CLOSED)
  end

  it "should set task as reopened when asking for it" do
    project = create(:project)
    user = create(:user)
    task = create(:task, taskable: project, reporter: user, assigned: user)

    task.reopen

    expect(task.status).to be(Task::REOPENED)
  end

  it "should set task as archived when asking for it" do
    project = create(:project)
    user = create(:user)
    task = create(:task, taskable: project, reporter: user, assigned: user)

    task.archive

    expect(task.status).to be(Task::ARCHIVED)
  end

  it "should returns project as parent_targetable" do
    task = create(:task_with_users_and_project)
    expect(task.parent_targetable).to be(task.taskable)
  end
end