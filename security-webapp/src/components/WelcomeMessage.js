import React from 'react';
import { Container, Header, Segment, Button } from 'semantic-ui-react';

class WelcomeMessage extends React.Component {
  render() {
    const complexName = "Serenity Meadows"; // Replace this with the name of your housing complex
    const securityAppName = "Security Gate Management System"; // Replace this with the actual name of your web app

    return (
      <Container text style={{ marginTop: '2rem' }}>
        <Segment raised>
          <Header as="h1" textAlign="center">Welcome to {complexName}</Header>
          <p>
            Thank you for choosing {complexName}'s {securityAppName}! Our innovative web app is specifically designed to provide top-notch security and simplify access control at the main entrance and exit gates of our exquisite housing complex.
          </p>
          <p>
            Embrace the peace of mind knowing that our dedicated security team is working around the clock to ensure your safety. With {securityAppName}, managing visitors, registering vehicles, and authorizing guest access has never been easier.
          </p>
          <p>
            We invite you to experience the convenience and efficiency of our application. Click the button below to log in and unlock a world of secure living.
          </p>
          <div style={{ display: 'flex', justifyContent: 'center', marginTop: '2rem' }}>
            <Button primary size="huge">Login to {securityAppName}</Button>
          </div>
        </Segment>
      </Container>
    );
  }
}

export default WelcomeMessage;
