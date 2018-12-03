class UsersController < ApplicationController

  def index
    from = params[:from]|| 1
    to = params[:to] || 100
    result = User.all[ from - 1, to]
    render json: {:stateus => 'success',:result => result},:callback => params[:callback]
  end

  def create
    id = params[:id]
    password = params[:password]
    group = params[:group]
    if id && password && group && User.where(:id => id).length == 0
      User.create(:id => id,:password => password,:group => group)
      render json: {:status => 'success',:message => "用户信息创建成功"},:callback => params[:callback]
    else
      render json: {:status => 'fail',:message => "用户信息创建失败"},:callback => params[:callback]
    end
  end

  def update
    id = params[:id]
    password = params[:password]
    group = params[:group]
    if id.length > 0 && User.where(:id => id).length > 0
      user = User.find(id)
      if password && group
        user.update(:group => group,:password => password)
        render json: {:status => 'success',:message => '用户信息更新成功'},:callback => params[:callback]
      else if !password && group
             user.update(:group => group)
             render json: {:status => 'success',:message => '用户信息更新成功'},:callback => params[:callback]
           else if password && !group
                  user.update(:password => password)
                  render json: {:status => 'success',:message => '用户信息更新成功'},:callback => params[:callback]
                else
                  render json: {:status => 'success',:message => '用户信息更新成功'},:callback => params[:callback]
                end
           end
      end
    else
      render json: {:status => 'error',:message => '用户查找失败，无此用户'},:callback => params[:callback]
    end
  end

  def delete
    id = params[:id]
    if id.length >=0 && User.where(:id => id).length > 0
      user = User.find(id)
      user.destroy
      render json: {:status => "success"},:callback => params[:callback]
    else
      render json: {:status => "error",:message => "该用户不存在"},:callback =>  params[:callback]
    end
  end

  def destroy
    User.delete_all
    render json: {:status => "success"},:callback => params[:callback]
  end

  def visit
    id = params[:id]
    password = params[:password]
    if id.length > 0 && password.length > 0 && User.where(:id => id).length >0
      user = User.find(id)
      if user.password === password
        group = user.group
        res = {:status => 'true',:group => group}
        render json: {:res => res},:callback => params[:callback]
      else
        render json: {:status => 'fail'},:callback => params[:callback]
      end
    else
      render json: {:status => 'false'},:callback => params[:callback]
    end
  end
end
