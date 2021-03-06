#
# Copyright (C) 2015 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CourseForMenuPresenter do
  let_once(:course) { course_model }
  let_once(:available_section_tabs) do
    Course.default_tabs.select do |tab|
      [ Course::TAB_ASSIGNMENTS, Course::TAB_HOME ].include?(tab[:id])
    end
  end
  let_once(:presenter) do
    CourseForMenuPresenter.new(
      course, available_section_tabs
    )
  end

  describe '#initialize' do
    it 'should limit available_section_tabs to be those for dashboard' do
      available_section_tab_ids = presenter.available_section_tabs.map do |tab|
        tab[:id]
      end
      expect(available_section_tab_ids).to include(Course::TAB_ASSIGNMENTS)
      expect(available_section_tab_ids).not_to include(Course::TAB_HOME)
    end
  end

  describe '#to_h' do
    it 'returns hash of info about course' do
      expect(presenter.to_h).to be_a Hash
    end

    it 'should include available_section_tabs as link element of hash' do
      expect(presenter.to_h[:links].length).to eq presenter.available_section_tabs.length
    end
  end
end
