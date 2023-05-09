<script>
export let data;
export let width;
export let numericScale;
export let mobile;

// export let yScale;

let tooltipWidth = 50;

$: x = data.x
$: y = data.y

const xNudge = mobile ? 25 : 90;
const yNudge =  mobile ? 35 : 55;

 $: xPosition = x + xNudge;
 $: yPosition = y + yNudge; 



</script>

{#if mobile}
<div class="tooltip" style="position: absolute; top: {yPosition}px; left: {xPosition}px" bind:clientWidth={tooltipWidth}>
    <h1><span>{data['שם ח״כ']}</span></h1>
    <h2>{data.party}</h2>
    <p>{(data.duration).toFixed(1)} שעות</p>
</div>
{:else}
    <div class="tooltip" style="position: absolute; top: {yPosition}px; left: {xPosition}px" bind:clientWidth={tooltipWidth}>
        <img src={data.img_url}/>
        <h1><span>{data['שם ח״כ']}</span></h1>
        <h2>{data.party}</h2>
        <p>{(data.duration).toFixed(1)} שעות</p>
    </div>
{/if}


<style>

.tooltip {
    padding: 8px 6px;
    background: white;
    box-shadow: rgba(0,0,0,0.15) 2px 3px 8px;
    border-radius: 3px;
    pointer-events: none;
    transition: top 300ms ease, left 300ms ease;
    direction: rtl;
    width: 100px
}


h1 {
    margin: 0;
    padding: 0;
    font-weight: 300;
    font-size: 1rem;
    font-weight: 700;
    margin-bottom: 6px;
    width: 100%;
}


span {
    /* background: #dda0dd50;
    font-size: 80%;
    margin-left: 2px; */
    padding: 2px 4px;
    display: inline-block;
    vertical-align: bottom;
    border-radius: 3px;
    color: rgba(0,0,0,0.7);
}

</style>