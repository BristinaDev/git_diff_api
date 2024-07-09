class CommitsController < ApplicationController
  def show
    begin
      client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
      user = params[:user]
      repo = params[:repo]
      commit_id = params[:id]
      @commit = client.commit("#{user}/#{repo}", commit_id)
      render json: @commit
    rescue Octokit::NotFound
      render json: { error: 'Commit not found' }, status: :not_found
    rescue Octokit::InvalidRepository
      render json: { error: 'Invalid repository' }, status: :unprocessable_entity
    end
  end

  def diff
    begin
      client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
      user = params[:user]
      repo = params[:repo]
      commit_id = params[:id]
      base_commit = params[:base]
      @diff = client.compare("#{user}/#{repo}", base_commit, commit_id)    
      render json: @diff
    rescue Octokit::NotFound
      render json: { error: 'Comparison not found' }, status: :not_found
    rescue Octokit::InvalidRepository
      render json: { error: 'Invalid repository' }, status: :unprocessable_entity
    end
  end
end
