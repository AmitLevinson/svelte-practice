<script>
  import { onMount } from 'svelte';
  import {calcHours} from './funs/helpers.js';
  import {forceSimulation, forceY, forceX, forceCollide} from 'd3-force';
  import {scaleLinear} from 'd3-scale';
  import {extent} from "d3-array";
  import data from '$data/data.js'
  import { csv } from 'd3-fetch';
  import Tooltip from './lib/Tooltip.svelte';
  import Axis from './lib/Axis.svelte'



  
  // let data = [];
  // onMount (async () => {
  //   const res = await csv('./src/data/data.csv')
  //   data = res;
    data.forEach(d => {
      d['duration'] = calcHours(d['שעות'])
      d['img_url'] = './src/data/mks/' + d['שם ח״כ'] + '.png'  
      if (d['מפלגה'] == "הציונות הדתית בראשות בצלאל סמוטריץ'") {
        d['party'] = 'הציונות הדתית'  
      } else if (d['מפלגה'] == 'התאחדות הספרדים שומרי תורה תנועתו של מרן הרב עובדיה יוסף זצ"ל') {
      d['party'] = 'ש"ס'
    } else {
      d['party'] = d['מפלגה']
    }
    });

  // })
  $: console.log(data)

    let w;
    $: width = w;
    $: height = width < 850 ? 500 : 700
    const margin = {top: 20, right: 60, bottom: 40, left: 30};
    
  $: marginInnerWidth = width - margin.left - margin.right;
  $: marginInnerHeight = height - margin.top - margin.bottom;

  
  let hoveredData;
  $: mobile =  width < 550 ? true : false;

  
  $: numericScale = scaleLinear()
      .domain(extent(data, d => d.duration))
      .range([0, mobile ? marginInnerHeight : marginInnerWidth]);
    
  $: RADIUS = mobile ? 8 : 20;
  
  let simulation = forceSimulation(data)
  
  let nodes = []; // Create an empty array to be populated when simulation ticks
  simulation.on("tick", () => {
      nodes = simulation.nodes(); // Repopulate and update
    });

  
  $: { 
    simulation.force('x', forceX().x(d => mobile ? marginInnerWidth / 2 : numericScale(d.duration)).strength(0.8))
    .force('y', forceY().y(d => mobile ? numericScale(d.duration) : marginInnerHeight / 2 ).strength(0.8))
    .force('collide', forceCollide().radius(RADIUS));
  }


</script>
<main>
<h1>סך השעות שחברי כנסת בילו בכנסת בתאריכים XX</h1>
<br>
<br>
{#if data.length}
  <div class = 'chart-container' bind:clientWidth={w}>
    <svg {width} {height}>
      <Axis mobile={mobile} numericScale={numericScale} marginInnerHeight={marginInnerHeight} marginInnerWidth={marginInnerWidth} margin={margin} />
      <g class="inner-chart" transform = "translate({mobile ? 0 : margin.left}, {margin.top})"> 
      {#each nodes as node}
      <clipPath id="myCircle">
        <circle cx={mobile ? 15 : 35} cy={mobile ? 15 : 35} r = {RADIUS}/>
        </clipPath>
        <foreignObject x={node.x} y={node.y} width="{mobile ? 68 : 168}" height="{mobile ? 68 : 168}" clip-path="url(#myCircle)"
        on:mouseover={() => hoveredData = node}
        on:mouseleave={() => hoveredData = false}
        opacity={hoveredData ? (hoveredData == node ? 1 : 0.45) : 1}   
        >
          <img src={node.img_url} alt="" width = 40% height =50% >
        </foreignObject>
        {/each}     
      </g>   
    </svg>
    {#if hoveredData}
    <Tooltip data={hoveredData} numericScale={numericScale} width={width} mobile={mobile}/>
    {/if}
  </div>
  {/if}
  </main>
<style>
.chart-container {

} 
</style>