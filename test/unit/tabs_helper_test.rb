require 'test_helper'

class TabsHelperTest < ActionView::TestCase
  include TabsHelper

  context 'Tab' do
    should 'return all tabs in order' do
      assert_equal 4, tabs.count
      assert_equal ['edit', 'metadata', 'history', 'admin'], tabs.map {|t| t.name}
    end

    should 'return tabs with expected titles' do
      assert_equal ['Edit', 'Metadata', 'History and notes', 'Admin'], tabs.map {|t| t.title}
    end

    should 'return tabs with expected paths' do
      assert_equal ['path', 'path/metadata', 'path/history', 'path/admin'], tabs.map {|t| t.path('path')}
    end

    should 'return a single tab by name' do
      assert_equal 'edit', Edition::Tab['edit'].name
    end
  end

  context 'Edit tab' do
    setup do
      @edit_tab = Edition::Tab['edit']
    end

    should 'have a path that matches the one provided' do
      assert_equal 'path/to', @edit_tab.path('path/to')
    end

    should 'have a tab link that targets an element with an ID matching its name' do
      link = tab_link(@edit_tab, 'path/to')
      assert_match 'data-target="#edit"', link
      assert_match 'href="path/to"', link
      assert_match 'aria-controls="edit"', link
      assert_match 'Edit', link
    end
  end
end
