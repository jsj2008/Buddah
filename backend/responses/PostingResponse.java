package services.responses;

import javax.xml.datatype.Duration;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class PostingResponse
{
    private Duration timeLeft;
    
    public PostingResponse()
    {
    }

    public Duration getTimeLeft()
    {
        return timeLeft;
    }

    public void setTimeLeft( Duration timeLeft )
    {
        this.timeLeft = timeLeft;
    }
    
}
