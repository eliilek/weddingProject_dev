class DocumentsController < ApplicationController
	
	def new
		@event = Event.find(params[:event_id])
		@document = Document.new
	end

	def create
		@event = Event.find(params[:event_id])
		@document = @event.documents.new(document_params)
		if @document.save
			redirect_to event_path(@event)
		else
      		@fail = "Please enter a title"
      		render :new
		end
	end
	def destroy
		Document.find(params[:id]).destroy
		redirect_to :back
	end

	private

	def document_params
		params.require(:document).permit(:event_id, :data, :title)
	end

end

