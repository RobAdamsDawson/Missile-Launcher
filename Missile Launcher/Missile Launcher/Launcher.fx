//--------------------------------------------------------------------------------------
// File: Tutorial04.fx
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// Constant Buffer Variables
//--------------------------------------------------------------------------------------
Texture2D txStoneColor : register(t1);
//Texture2D txStoneBump : register(t2);
SamplerState txStoneSampler : register (s1);

cbuffer ConstantBuffer : register(b6)
{
	matrix World;
	//matrix WorldM;
	matrix View;
	matrix Projection;
}

//--------------------------------------------------------------------------------------
struct VS_INPUT
{
	float4 Pos : POSITION;
	float2 Tex : TEXCOORD;
};

struct VS_OUTPUT
{
	float4 Pos : SV_POSITION;
	float2 Tex : TEXCOORD;
};

//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
VS_OUTPUT VS_main(VS_INPUT input)
{
	VS_OUTPUT output = (VS_OUTPUT)0;
	output.Pos = mul(input.Pos, World);
	//output.Pos = mul(output.Pos, WorldM);
	output.Pos = mul(output.Pos, View);
	output.Pos = mul(output.Pos, Projection);

	output.Tex = input.Tex;
	//if (World[3].y >= 5.0)
	//{
	//	output.Color = float4(1, 1, 1, 1);
	//}

	return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS_main(VS_OUTPUT input) : SV_Target
{
	return  txStoneColor.Sample(txStoneSampler, input.Tex);
	//return input.Color;
}
