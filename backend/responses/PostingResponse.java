package services.responses;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class PostingResponse
{
    private long timeLeft;
    
    public PostingResponse()
    {
    }

    public long getTimeLeft()
    {
        return timeLeft;
    }

    public void setTimeLeft( long timeLeft )
    {
        this.timeLeft = timeLeft;
    }
    
}
