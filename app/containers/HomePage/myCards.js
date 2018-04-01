import React, { Component } from 'react';
import Cards, { Card } from 'react-swipe-card'
import './styles.css';

const Wrapper = ({data, onSwipeLeft, onSwipeRight, onSwipeTop}) => {
  return (
    <Cards onEnd={console.log("action('end')")} className='master-root'>
      {Object.keys(data).map(item =>
        <Card 
          key={item}
          onSwipeLeft={() => onSwipeLeft(item)}
          onSwipeRight={() => onSwipeRight(item)}
          onSwipeTop={() => onSwipeTop(item)}>
          <h2>{item}</h2>
        <img src={data[item]}/>
        </Card>
      )}
    </Cards>
  )
}

export default class MyCards extends Component {
    
    constructor(){
        super();

        const req = require.context("./images", false, /.*\.jpg$/);
        let images = {};
        req.keys().forEach(function(key){
            images[key.replace('./', '')] = req(key);
        });
        this.state = {
            text: [],
            human: [],
            others: [],
            images: images
        }
    }

    onSwipeTop = (item) => {
        // delete this.state.images[item]
        this.setState(prevState => ({ others: [...prevState.others, item]}));
    }

    onSwipeLeft = (item) => {
        // delete this.state.images[item]
        this.setState(prevState => ({ human: [...prevState.human, item]}));
    }
    
    onSwipeRight = (item) => {
        // delete this.state.images[item]
        this.setState(prevState => ({ text: [...prevState.text, item]   }));
    }
    
    render() {
    return (
        <div>
        <Wrapper 
          onSwipeLeft={this.onSwipeLeft}
          onSwipeRight={this.onSwipeRight}
          onSwipeTop={this.onSwipeTop}
          data={this.state.images}
        />
        <ul>Others: {this.state.others.map(data => <li>{data}</li>)}</ul>
        <ul>Human: {this.state.human.map(data => <li>{data}</li>)}</ul>
        <ul>Text: {this.state.text.map(data => <li>{data}</li>)}</ul>

        </div>
    )
}
}