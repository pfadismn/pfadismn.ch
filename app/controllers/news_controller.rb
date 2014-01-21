class NewsController < ApplicationController
  load_and_authorize_resource

  def index
    published_to = params[:published_to] || :web
    @news = News.published_to(published_to.to_sym)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  def new
    @news.published_at ||= Time.now
    @news.publish_to = [:web]

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      @news.creator = current_user
      
      if @news.save
        format.html { redirect_to news_index_path, notice: "News wurde erstellt" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to news_index_path, notice: 'News was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_path }
    end
  end
end
