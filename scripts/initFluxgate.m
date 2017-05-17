function [ fluxgate ] = initFluxgate( lon, lat, steps, Xq, Yq, sla_pp_cog_q, ssha_q, pPq, Wq )
%INITFLUXGATE Initiates a fluxgate with specified path and steps
%   fluxgate = initFluxgate(LON, LAT, STEPS, XQ, YQ, SLA_PPCOG_Q, SSHA_Q, PPQ, WQ)
%   initiates a fluxgate from LON and LAT, with a detail of STEPS. XQ,
%   YQ, and the following data are the grid interpolated data yoy wish to
%   work on.
%
%   See also FREEBOARDANALYSIS

warning('Implamentation of grid data will change in future versions');

%% Generate struct
fluxgate = struct('lon', [], 'lat', [], 'steps', steps, ...
                  'sla', [], 'ssha', [], 'pP', [], 'W', [], 'class', [],...
                  'freeboard', [], 'iceThickness', []);

%% Creating path for fluxgate
fluxgate.lon = linspace(lon(1), lon(2), fluxgate.steps);
fluxgate.lat = linspace(lat(1), lat(2), fluxgate.steps);

%% Interpolates data on path
fluxgate.sla = interp2(Xq, Yq, sla_pp_cog_q, fluxgate.lon, fluxgate.lat);
fluxgate.pP = interp2(Xq, Yq, pPq, fluxgate.lon, fluxgate.lat);
fluxgate.W = interp2(Xq, Yq, Wq, fluxgate.lon, fluxgate.lat);
fluxgate.ssha = interp2(Xq, Yq, ssha_q, fluxgate.lon, fluxgate.lat);

%% Classifies and masks data
fluxgate.sla(~isnan(fluxgate.ssha)) = nan;
fluxgate.class = zeros(fluxgate.steps,1);
fluxgate.class(fluxgate.pP > 30 & fluxgate.W < 2) = 4;
end

