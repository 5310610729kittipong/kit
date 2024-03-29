class FormsController < ApplicationController
  # GET /forms
  # GET /forms.json
  def index
 
  end

  #print form
  def show
    @form = Form.find(params[:id])
    
    @roomtype = DetailRoom.all_types
    @time = Room.all_times
    @day_list = Room.all_days
  end

  #create form
  def new
    @form = Form.new
    @room = Room.find(session[:id_room])
    @roomtype = DetailRoom.all_types
    @time = Room.all_times
    @day_list = Room.all_days
    time_arr = session[:time_select].split("-")
    @starttime = time_arr[0]
    @endtime = time_arr[1]
    @date_select = session[:date_select]
    @this_type = DetailRoom.find_by_roomname(@room.roomname).room_type
    
  end

  # GET /forms/1/edit
  def edit

  end

  #create form
  def create
    @roomtype = DetailRoom.all_types
    @time = Room.all_times
    @day_list = Room.all_days
    temp_form = params[:form]
    #staff can reserve in today 
    if temp_form[:date_to_reserve].to_s > Date.today.to_s || session[:admin] != nil
      pos = params[:form]["position"]
      if params[:form]["position"] != nil
        temp_form[:position] = params[:form]["position"][pos.keys[0]]
      end
      if tools_str = params[:form][:require_tool].keys
        temp_form[:require_tool] = tools_str.join(",")
      end
      @form = Form.new(temp_form)
      if @form.valid? && @form.save 
        reserf = {}
        reserf["roomname"] = @form.roomname
        reserf["date_to_reserve"] = @form.date_to_reserve
        reserf["start_time"] = @form.start_time
        reserf["finish_time"] = @form.finish_time
        reserf["tel"] = @form.tel
        reserf["email"] = @form.email
        reserf["status"] = "nonconsidered"
        @reserve = Reserve.new(reserf)
        if @reserve.save
          flash[:notice] = "Create form and reserve success"
          session[:id_room]=nil
          session[:time_select]=nil
          session[:date_select] = nil
          #redirect_to rooms_path
          redirect_to form_path(@form)
        else
          flash[:notice] = "Can not create reserve"
          redirect_to rooms_path
        end
      else
          flash[:notice] = "Please insert all detail"
          redirect_to new_form_path
      end
    else
      flash[:notice] = "Can not reserve in today, Please Contact Staff by yourself"
      redirect_to new_form_path
    end
  end

  
  def update
    
  end

  
  def destroy
   
  end
end
