package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class ViewUserRatingResultResponse
{
    boolean ready;
    Feedback[] feedbackList;

    public ViewUserRatingResultResponse()
    {
    }

    public boolean isReady()
    {
        return ready;
    }

    public void setReady( boolean ready )
    {
        this.ready = ready;
    }

    public Feedback[] getFeedbackList()
    {
        return feedbackList;
    }

    public void setFeedbackList( Feedback[] feedbackList )
    {
        this.feedbackList = feedbackList;
    }
}
