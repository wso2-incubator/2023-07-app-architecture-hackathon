import React from 'react';
import { Container, Message } from 'semantic-ui-react';

const UnderConstructionMessage = () => {
  return (
    <Container style={{ marginTop: '2rem', textAlign: 'center' }}>
      <Message icon info>
        <i className="icon wrench"></i>
        <Message.Content>
          <Message.Header>This Page is Under Construction</Message.Header>
          <p>We apologize for the inconvenience, but this page is currently being worked on and will be available soon.</p>
        </Message.Content>
      </Message>
    </Container>
  );
};

export default UnderConstructionMessage;
