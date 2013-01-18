package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class ViewUserRatingResultResponse
{
    boolean ready;
    ArrayList<Feedback> feedbackList;

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

    public ArrayList<Feedback> getFeedbackList()
    {
        return feedbackList;
    }

    public void setFeedbackList( ArrayList<Feedback> feedbackList )
    {
        this.feedbackList = feedbackList;
    }
}
