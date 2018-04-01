import React, { Component } from 'react';
import Cards, { Card } from 'react-swipe-card'
import './styles.css';

const Wrapper = ({data, onSwipeLeft, onSwipeRight}) => {
  return (
    <Cards onEnd={console.log("action('end')")} className='master-root'>
      {Object.keys(data).map(item =>
        <Card 
          key={item}
          onSwipeLeft={() => onSwipeLeft(item)}
          onSwipeRight={() => onSwipeRight(item)}>
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
        let data = [];
        req.keys().forEach(function(key){
            data.push(key.replace('./', ''));
            images[key.replace('./', '')] = req(key);
        });
        this.state = {
            data: data,
            liked: [],
            disliked: [],
            images: images
        }
    }



    onSwipeLeft = () => {
        const newData = this.state.data.slice(1);
        this.setState(prevState => ({ data: newData, disliked: [...prevState.disliked, prevState.data[0]]}));
    }
    onSwipeRight = () => {
        const newData = this.state.data.slice(1);
        this.setState(prevState => ({ data: newData, liked: [...prevState.liked, prevState.data[0]] }));
    }
    
    render() {
    return (
        <div>
        <Wrapper 
          onSwipeLeft={this.onSwipeLeft}
          onSwipeRight={this.onSwipeRight}
          data={this.state.images}
        />
        <ul>Liked: {this.state.liked.map(data => <li>{data}</li>)}</ul>
        <ul>Disliked: {this.state.disliked.map(data => <li>{data}</li>)}</ul>
        </div>
    )
}
}