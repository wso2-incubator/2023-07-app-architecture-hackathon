import React from 'react';
import { Button, Container, Message } from 'semantic-ui-react';
import { useAuthContext } from "@asgardeo/auth-react";

const SecurityStaffWelcome = () => {
  const { signIn } = useAuthContext();
  
  return (
    <Container style={{ marginTop: '2rem', textAlign: 'center' }}>
      <Message icon positive>
        <i className="icon shield"></i>
        <Message.Content>
          <Message.Header>Welcome, Security Staff</Message.Header>
          <p>Thank you for your dedication to keeping our community safe and secure.</p>
          <p>Your vigilance and hard work contribute to the peace of mind of our residents and visitors.</p>
          <p>With your expertise and the support of our advanced Security Gate Management System, we stand strong in providing top-notch security.</p>
          <p>Feel free to use the system's features to efficiently manage access, record visitor logs, and respond promptly to any security incidents.</p>
          <p>Together, we can ensure a safe living environment for everyone in LotusGroove.</p>
        </Message.Content>
      </Message>
     <Button primary onClick={() => signIn()} size="huge">Login to LotusGroove</Button>
    </Container>
  );
};

export default SecurityStaffWelcome;
