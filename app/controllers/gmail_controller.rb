class GmailController < ApplicationController
    def redirect
        client = Signet::OAuth2::Client.new({
          client_id: Rails.application.credentials.google[:id],
          client_secret: Rails.application.credentials.google[:secret],
          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
          scope: Google::Apis::GmailV1::AUTH_GMAIL_READONLY,
          redirect_uri: url_for(:action => :callback)
        })
      
        redirect_to client.authorization_uri.to_s
      end
      def callback
        client = Signet::OAuth2::Client.new({
            client_id: Rails.application.credentials.google[:id],
            client_secret: Rails.application.credentials.google[:secret],
          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
          redirect_uri: url_for(:action => :callback),
          code: params[:code]
        })
      
        response = client.fetch_access_token!
      
        session[:access_token] = response['access_token']
      
        redirect_to url_for(:action => :labels)
      end
      def labels
        client = Signet::OAuth2::Client.new(access_token: session[:access_token])
      
        service = Google::Apis::GmailV1::GmailService.new
      
        service.authorization = client
      
        @labels_list = service.list_user_labels('me')
      end
    def index
  
    end
end
