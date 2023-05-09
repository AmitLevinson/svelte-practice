<script>
    import { text } from "svelte/internal";

export let numericScale;
export let marginInnerHeight;
export let marginInnerWidth;
export let margin;
export let mobile;

let xTicks = numericScale.ticks(3)

</script>
{#if mobile}
<g class="axis-y" transform="translate(0, {margin.bottom})">
    {#each xTicks as tick, i}
        <g class="tick">
            <line x1={marginInnerWidth} y1={numericScale(tick)} x2={0} y2={numericScale(tick)} stroke="#d3d3d3" stroke-width='0.75'/>
            <text x={marginInnerWidth} y = {numericScale(tick)} text-anchor='end'>
                {tick}
            </text>
        </g>
        {/each}
</g>
{:else}
<g class="axis-x" transform="translate({margin.left}, {0})">
    {#each xTicks as tick, i}
    <g class="tick">
        <line x1={numericScale(tick)} y1={marginInnerHeight} x2={numericScale(tick)} y2={0} stroke="#d3d3d3" stroke-width='0.75'/>
        <text x={numericScale(tick)} y = {margin.bottom} text-anchor='middle' transform="translate({0}, {marginInnerHeight})">
            {tick}
        </text>
    </g>
    {/each}
</g>
{/if}

<style>
    .tick {
        font-size: 1.1rem;
        fill: #878787;
        
    }
</style>