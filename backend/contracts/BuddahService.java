package services.contracts;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.*;
import javax.xml.bind.JAXBElement;

import com.google.gson.Gson;

import constants.QueueConstants;

import logging.Logger;

import services.queue.*;
import services.requests.*;
import services.responses.*;

@Path( "/services" )
@Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON, MediaType.TEXT_PLAIN } )
public class BuddahService
{

    private final static String ACCOUNT_QUEUE = QueueConstants.ACCOUNT_QUEUE;
    private final static String POSTING_QUEUE = QueueConstants.POSTING_QUEUE;

    private static Gson gson = new Gson();

    @PUT
    @Path( "initiateRegister" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public InitiateRegisterResponse initiateRegister( @Context HttpServletRequest req,
            InitiateRegisterRequest initiateRegisterRequest )
    {
        Logger.logRequest( req, "initiateRegister" );

//        System.out.println( String.format( "initiateRegisterRequest: %s", initiateRegisterRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "initiateRegister".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( initiateRegisterRequest ).getBytes() );

        InitiateRegisterResponse response = new InitiateRegisterResponse();

        response.setInstructionMessage( "Please wait for a text to arrive at your number.  And yea, we'll make millions." );

        return response;
    }

    @POST
    @Path( "confirmRegister" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public ConfirmRegisterResponse confirmRegister( @Context HttpServletRequest req,
            ConfirmRegisterRequest confirmRegisterRequest )
    {
        Logger.logRequest( req, "confirmRegister" );

//        System.out.println( String.format( "confirmRegisterRequest: %s", confirmRegisterRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "confirmRegister".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( confirmRegisterRequest ).getBytes() );

        ConfirmRegisterResponse response = new ConfirmRegisterResponse();
        response.setToken( "ABCD-EFGH-IJKL-MNOP-QRST-UVWX-YZ" );

        return response;
    }

    @POST
    @Path( "login" )
    @Consumes( { MediaType.APPLICATION_JSON } )
    @Produces( { MediaType.APPLICATION_JSON } )
    public LoginResponse login( @Context HttpServletRequest req, LoginRequest loginRequest )
    {
        Logger.logRequest( req, "login" );

//        System.out.println( String.format( "loginRequest: %s", loginRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, "login".getBytes() );
        WorkerQueue.SendMessage( ACCOUNT_QUEUE, gson.toJson( loginRequest ).getBytes() );

        LoginResponse response = new LoginResponse();
        response.setResult( true );

        return response;
    }

    @GET
    @Path( "getDeals" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public GetDealsResponse getDeals( @Context HttpServletRequest req, GetDealsRequest getDealsRequest )
    {
        Logger.logRequest( req, "getDeals" );

//        System.out.println( String.format( "getDealsRequest: %s", getDealsRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "getDeals".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( getDealsRequest ).getBytes() );

        GetDealsResponse response = new GetDealsResponse();

        return response;
    }

    @POST
    @Path( "rating" )
    @Consumes( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public RatingResponse rating( @Context HttpServletRequest req, RatingRequest ratingRequest )
    {
        Logger.logRequest( req, "rating" );

//        System.out.println( String.format( "ratingRequest: %s", ratingRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "rating".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( ratingRequest ).getBytes() );

        RatingResponse response = new RatingResponse();

        return response;
    }

    @PUT
    @Path( "posting" )
    public PostingResponse posting( @Context HttpServletRequest req, PostingRequest postingRequest )
    {
        Logger.logRequest( req, "posting" );

//        System.out.println( String.format( "postingRequest: %s", postingRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "posting".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( postingRequest ).getBytes() );

        PostingResponse response = new PostingResponse();
        response.setTimeLeft( postingRequest.getListing().getStartTime() - Calendar.getInstance().getTimeInMillis() );

        return response;
    }

    @GET
    @Path( "viewPost" )
    @Produces( { MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON } )
    public ViewPostResponse viewPost( @Context HttpServletRequest req, ViewPostRequest viewPostRequest )
    {
        Logger.logRequest( req, "viewPost" );

//        System.out.println( String.format( "viewPostRequest: %s", viewPostRequest.toString() ) );

        // TODO ENCRYPT + ACK
        WorkerQueue.SendMessage( POSTING_QUEUE, "viewPost".getBytes() );
        WorkerQueue.SendMessage( POSTING_QUEUE, gson.toJson( viewPostRequest ).getBytes() );

        ViewPostResponse response = new ViewPostResponse();

        return response;
    }

}
