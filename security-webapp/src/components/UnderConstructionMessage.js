import React from 'react';
import { Button, Container, Message } from 'semantic-ui-react';
import VisitScheduler from './VisitScheduler';

const UnderConstructionMessage = () => {

  const scheduleVisit = () => {
    console.log("Visit scheduled!"); // You can add your scheduling logic here
  };


  return (
    <>
    <Container style={{ marginTop: '2rem', textAlign: 'center' }}>
      {/* <Link to="/schedule-visit">
        <Button>Click here to Schedule a new Visit</Button>
      </Link> */}
      <VisitScheduler onScheduleVisit={scheduleVisit} />
      </Container>
      <Container style={{ marginTop: '2rem', textAlign: 'center' }}>
        <Message icon info>
          <i className="icon wrench"></i>
          <Message.Content>
            <Message.Header>This Page is Under Construction</Message.Header>
            <p>We apologize for the inconvenience, but this page is currently being worked on and will be available soon.</p>
          </Message.Content>
        </Message>
      </Container>
      {/* Add button for new schedules */}
    </>
  );
};

export default UnderConstructionMessage;
