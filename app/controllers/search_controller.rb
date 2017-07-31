class SearchController < ApplicationController
	def search
	  if params[:query].nil?
	    @documents = []
	  else
	    @documents = Document.search params[:query]
	  end
	end
	
end
  