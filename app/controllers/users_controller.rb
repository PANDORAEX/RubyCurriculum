class UsersController < ApplicationController
  def login
    flash[:usererror] = ""
    @loginuser = Users.new
  end
  
  def logincheck
    userid = params[:users]['userid']
    password = params[:users]['password']
    flash[:usererror] = ""
    if userid == "" then
      flash[:usererror] += "ユーザ名を入力してください。\n"
    elsif userid.length != 8 then
      flash[:usererror] += "ユーザ名は8桁で入力してください。\n"
    elsif userid !~ /^[0-9A-Za-z]+$/ then
      flash[:usererror] += "ユーザ名は半角英数字で入力してください。\n"
    end
    if password == "" then
      flash[:usererror] += "パスワードを入力してください。\n"
    end
    
    if flash[:usererror] != "" then
      flash[:usererror] = flash[:usererror][0..-2]
      @loginuser = Users.new(userid: userid)
      render 'login.html.erb'
    else
      @user = Users.find_by(:userid => userid)
      if @user == nil then
        flash[:usererror] = "ユーザ名またはパスワードに誤りがあります。"
        @loginuser = Users.new(userid: userid)
        render 'login.html.erb'
      else
        if @user.password == password then
          redirect_to '/projects/index'
        else
          flash[:usererror] = "ユーザ名またはパスワードに誤りがあります。"
          @loginuser = Users.new(userid: userid)
          render 'login.html.erb'
        end
      end
    end
  end
end