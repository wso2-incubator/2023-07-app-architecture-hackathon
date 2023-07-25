import React, { useState, useEffect } from 'react';
import { Container, Input} from 'semantic-ui-react';
import { useAuthContext } from "@asgardeo/auth-react";
import UnderConstructionMessage from './UnderConstructionMessage';
import SecurityStaffWelcome from './SecurityStaffWelcome';
function Schedules() {

  const [items, setitems] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const baseUrl = process.env.REACT_APP_RESOURCE_SERVER_URL;

  const { state, httpRequest } = useAuthContext();
  var path = "/items";
  var isAttachToken = false;
  var isWithCredentials = false;

  const requestConfig = {
    headers: {
      "Access-Control-Allow-Origin": "*"
    },
    method: "GET",
    url: baseUrl + path,
    attachToken: isAttachToken,
    withCredentials: isWithCredentials
  };

  

  useEffect(() => {
    // call API
    // async function fetchitems() {
    //   console.log('baseUrl', baseUrl);
    //   const response = await httpRequest(requestConfig);
    //   console.log(response.data);
    //   setitems(response.data);
    // }

    // fetchitems();
  }, []);

  useEffect(() => {
    const results = items.filter(item =>
      item.title.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setSearchResults(results);
  }, [items, searchTerm]);

  const handleSearchChange = event => {
    setSearchTerm(event.target.value);
  };

  if(state.isAuthenticated) {
    return (
      <Container>
        <Input
          type="text"
          placeholder="Search by schedule Id"
          value={searchTerm}
          onChange={handleSearchChange}
          fluid
        />
        {/* TODO change logic based on the logged in status */}
           <UnderConstructionMessage/>
      </Container>
    );
  } else {
  return (
    <Container>
         <SecurityStaffWelcome/>
    </Container>
  );
  }
}

export default Schedules;
