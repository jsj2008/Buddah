package services.responses;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import model.services.Feedback;

@XmlRootElement
public class ViewPostResultResponse
{
    ArrayList<Feedback> feedbackList;
    
    public ViewPostResultResponse()
    {
    }

    public ArrayList<Feedback> getFeedbackList()
    {
        return feedbackList;
    }

    public void setFeedbackList( ArrayList<Feedback> feedbackList )
    {
        this.feedbackList = feedbackList;
    }}
