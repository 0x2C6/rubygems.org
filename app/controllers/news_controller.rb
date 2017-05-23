class NewsController < ApplicationController
  before_action :set_page

  def show
    @releases = Rubygem.joins(:latest_version)
      .merge(Version.indexed.by_created_at.recent)
      .paginate(page: @page, per_page: 10, total_entries: 100)
  end

  def popular
    @title = "New Releases — Popular Gems"
    @releases = Rubygem.joins(:latest_version)
      .by_downloads
      .merge(Version.indexed.by_created_at.recent)
      .paginate(page: @page, per_page: 10, total_entries: 100)

    render :show
  end
end
