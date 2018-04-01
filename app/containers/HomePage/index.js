import React, { Component } from 'react';
import MyCards from "./myCards.js";

class Homepage extends Component {

  render() {
    return (
      <div className="App">
        <header className="App-header">
  
          <h1 className="App-title">Welcome to Tinder</h1>
        </header>
        <MyCards />
      </div>
    );
  }
}

export default Homepage;