package services.requests;

public class ViewPostRequest
{
    String userId;
    String username;
    
    public ViewPostRequest()
    {
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername( String username )
    {
        this.username = username;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId( String userId )
    {
        this.userId = userId;
    }

}
