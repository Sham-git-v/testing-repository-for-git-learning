import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import D3 from '@salesforce/resourceUrl/D3';

export default class D3BarChart extends LightningElement {
    d3Initialized=false;
    connectedCallback(){
        console.log('connected');
       
    }
    renderedCallback(){
        console.log('rendered');
        if(this.d3Initialized){
            return;
        }   
        this.d3Initialized=true;
        Promise.all([loadScript(this, D3 + "/d3.min.js")])
        .then(()=>{
            console.log('d3 library rendered successfully');
            this.initializeD3();
        })
        .catch(error=>{
            console.error('error is: ', error);
        });
    }

    initializeD3(){
        //getting the data here
        
        const data = [
            { label: 'Jan', value: 25 },
            { label: 'Feb', value: 50 },
            { label: 'Mar', value: 90 },
            { label: 'Apr', value: 75 },
            { label: 'May', value: 120 },
            { label: 'Jun', value: 85 }
        ];

        //give dimensions for the chart or bar
        const margin={top:20,right:20,bottom:30,left:40};
        const width=400-margin.left -margin.right;
        const height=300-margin.top-margin.bottom;

        //show the chart in html file in svg tag and defining it's dimensions
        const svg=d3.select(this.template.querySelector('svg.d3-chart'))
        .attr('width',width+margin.left+margin.right)
        .attr('height', height+margin.top+margin.bottom)
        .append('g')
        .attr('transform',`translate(${margin.left},${margin.top})`);

        //crateing x scale  
        const xScale=d3.scaleBand()
            .domain(data.map(d=>d.label))
            .range([0,width])
            .padding(0.2)
    

        // Create the Y-axis scale (d3-scale)
        const yScale=d3.scaleLinear()
            .domain([0,d3.max(data,d=>d.value)])
            .range([height,0])

        // Draw the X-axis (d3-axis)
        svg.append('g')
            .attr('transform',`translate${height}`)
            .call(d3.axisBottom(xScale))

        
        //Draw the Y-axis 
        svg.append('g')
            .call(d3.axisLeft(yScale))


        // Create and draw the bars (d3-selection, d3-shape)
        svg.selectAll('.bar')
            .data(data)
            .enter() // 'enter' selects data points that don't have a corresponding element yet
            .append('rect')
            .attr('class', 'bar')
            .attr('x', d => xScale(d.label))
            .attr('y', d => yScale(d.value))
            .attr('width', xScale.bandwidth())
            .attr('height', d => height - yScale(d.value))
            .attr('fill', '#4E79A7'); // A nice blue color


    }
}