class ProjectsController < ApplicationController
  def index
    
  end

  def add
    flash[:error] = ""
    @newproject = Project.new
  end
  
  def list
    @projects = Project.all
    if @projects.empty? then
      flash[:listerror] = "レコードが登録されていません。"
    end
  end
  
  def addcheck
    startdate = params[:project]['start_date']
    projectno = params[:project]['project_no']
    projectname = params[:project]['project_name']
    protypecode = params[:project]['protype_code']
    languagecode = params[:project]['language_code']
    summary = params[:project]['summary']
    statuscode = params[:project]['status_code']
    customer = params[:project]['customer']
    charge = params[:project]['charge']
    reviewer = params[:project]['reviewer']
    releasedate = params[:project]['release_date']
    remarks = params[:project]['remarks']
    
    flash[:error] = ""
    if startdate == "" then
      flash[:error] += "発生日を入力してください。\n"
    elsif startdate !~ /^[0-9]{4}[\/][0-9]{2}[\/][0-9]{2}$/
      flash[:error] += "発生日は yyyy/MM/dd の形式で入力してください。\n"
    elsif !date_valid?(startdate) then
      flash[:error] += "発生日は カレンダーに存在しない日付です。\n"
    end
    if projectno == "" then
      flash[:error] += "案件番号を入力してください。\n"
    end
    if projectname == "" then
      flash[:error] += "案件名を入力してください。\n"
    end
    if protypecode == "" then
      flash[:error] += "工程区分を選択してください。\n"
    end
    if languagecode == "" then
      flash[:error] += "開発言語を選択してください。\n"
    end
    if summary == "" then
      flash[:error] += "概要を入力してください。\n"
    end
    if statuscode == "" then
      flash[:error] += "状態を選択してください。\n"
    end
    if releasedate !="" then
      if releasedate !~ /^[0-9]{4}[\/][0-9]{2}[\/][0-9]{2}$/ then
        flash[:error] += "リリース日は yyyy/MM/dd の形式で入力してください。\n"
      elsif !date_valid?(releasedate) then
        flash[:error] += "リリース日は カレンダーに存在しない日付です。\n"
      end
    else
      releasedate = nil
    end
    
    if flash[:error] != "" then
      flash[:error] = flash[:error][0..-2]
      @newproject = Project.new(start_date: startdate, project_no: projectno, project_name: projectname, protype_code: protypecode,
                                language_code: languagecode, summary:summary, status_code:statuscode, customer:customer, charge:charge,
                                reviewer:reviewer, release_date:releasedate, remarks:remarks)
      render '/projects/add'
      
    else
      if ProjectSequence.find_by(:name => 'sequence').number >= 10000 then
        flash[:error] = "登録可能な一連番号が無いため、登録を行えません。"
        @newproject = Project.new(start_date: startdate, project_no: projectno, project_name: projectname, protype_code: protypecode,
                                  language_code: languagecode, summary:summary, status_code:statuscode, customer:customer, charge:charge,
                                  reviewer:reviewer, release_date:releasedate, remarks:remarks)
        render '/projects/add'
      else
        @sequence = ProjectSequence.find_by(:name => 'sequence')
        @project = Project.new
        @project.project_id = @sequence.number
        @project.start_date = startdate
        @project.project_no = projectno
        @project.project_name = projectname
        @project.protype_code = protypecode
        @project.language_code = languagecode
        @project.summary = summary
        @project.status_code = statuscode
        @project.customer = customer
        @project.charge = charge
        @project.reviewer = reviewer
        @project.release_date = releasedate
        @project.remarks = remarks
        @project.save
        @sequence.number = @sequence.number + 1
        @sequence.save
        redirect_to '/projects/add'
      end
    end
  end
  
  def delete
    Project.find_by(:project_id => params[:projectid]).delete
    redirect_to '/projects/list'
  end
  
  def change
    flash[:changeerror] = ""
    @changeproject = Project.find_by(:project_id => params[:projectid])
    @changeproject.start_date = @changeproject.start_date.strftime('%Y/%m/%d')
    if @changeproject.release_date != nil then
      @changeproject.release_date = @changeproject.release_date.strftime('%Y/%m/%d')
    end
  end
  
  def editcheck
    @changeproject = Project.find_by(:project_id => params[:projectid])
    languagecode = params[:project]['language_code']
    summary = params[:project]['summary']
    statuscode = params[:project]['status_code']
    customer = params[:project]['customer']
    charge = params[:project]['charge']
    reviewer = params[:project]['reviewer']
    releasedate = params[:project]['release_date']
    remarks = params[:project]['remarks']
    flash[:changeerror] = ""
    if languagecode == "" then
      flash[:changeerror] += "開発言語を選択してください。\n"
    end
    if summary == "" then
      flash[:changeerror] += "概要を入力してください。\n"
    end
    if statuscode == "" then
      flash[:changeerror] += "状態を選択してください。\n"
    end
    if releasedate !="" then
      if releasedate !~ /^[0-9]{4}[\/][0-9]{2}[\/][0-9]{2}$/ then
        flash[:changeerror] += "リリース日は yyyy/MM/dd の形式で入力してください。\n"
      elsif !date_valid?(releasedate) then
        flash[:changeerror] += "リリース日は カレンダーに存在しない日付です。\n"
      end
    else
      releasedate = nil
    end
    @changeproject.language_code = languagecode
    @changeproject.summary = summary
    @changeproject.status_code = statuscode
    @changeproject.customer = customer
    @changeproject.charge = charge
    @changeproject.reviewer = reviewer
    @changeproject.release_date = releasedate
    @changeproject.remarks = remarks
    if flash[:changeerror] != "" then
      flash[:changeerror] = flash[:changeerror][0..-2]
      render 'change.html.erb'
    else
      @changeproject.save
      redirect_to '/projects/list'
    end
  end
  
  def date_valid?(str)
    !! Date.parse(str) rescue false
  end
  
end
