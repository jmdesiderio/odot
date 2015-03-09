require 'spec_helper'

describe "Viewing todo items" do
	let(:user) { todo_list.user }
	let!(:todo_list) { create(:todo_list) }
	before { sign_in user, password: "treehouse1" }

	it "displays the title of the todo list" do
		visit_todo_list(todo_list)
		within("h1#todo_list_title") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when the todo list is empty" do
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end

	it "displays item content when a todo list has items" do
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")
		
		visit_todo_list(todo_list)

		expect(page.all("tbody tr").size).to eq(2)
		
		within "tbody" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Eggs")
		end
	end
end