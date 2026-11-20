# frozen_string_literal: true

RSpec.describe "Quick replies" do
  let!(:theme) { upload_theme_component }
  let(:composer) { PageObjects::Components::Composer.new }
  let(:topic_page) { PageObjects::Pages::Topic.new }

  fab!(:topic) { Fabricate(:post).topic }
  fab!(:group)
  fab!(:support_user) { Fabricate(:user, groups: [group]) }
  fab!(:other_user, :user)

  before do
    theme.update_setting(:quick_replies_groups, group.id.to_s)
    theme.update_setting(:quick_replies, [{ "text" => "Happy to help!", "label" => "Happy" }])
    theme.save!
  end

  it "inserts the reply text when a bubble is clicked" do
    sign_in(support_user)
    topic_page.visit_topic_and_open_composer(topic)

    find(".quick-replies__bubble", text: "Happy").click

    expect(composer).to have_content("Happy to help!")
  end

  it "hides the bubbles from users outside the groups" do
    sign_in(other_user)
    topic_page.visit_topic_and_open_composer(topic)

    expect(composer).to be_opened
    expect(page).to have_no_css(".quick-replies")
  end
end
