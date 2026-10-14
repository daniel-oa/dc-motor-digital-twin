v = 1.5;
tl = 0;

v_values = 0.1:0.1:1.5;
number_of_torque_values = 11;
stall_torque = 0.245e-3;

v_grid = [];
tl_grid = [];

for k = 1:length(v_values)
    maximum_load_torque = -stall_torque*(v_values(k)/1.5);
    torque_values = linspace(0,maximum_load_torque, number_of_torque_values);
    v_grid = [v_grid; repmat(v_values(k), number_of_torque_values, 1)]
    tl_grid = [tl_grid; torque_values(:)];
end
model = 'Faulhaber0615_DigitalTwin';
for k = 1:length(v_grid)
    simulation_inputs(k) = Simulink.SimulationInput(model);
    simulation_inputs(k) = simulation_inputs(k).setVariable('v', v_grid(k));
    simulation_inputs(k) = simulation_inputs(k).setVariable('tl', tl_grid(k));
end

simulation_results = sim(simulation_inputs);

save('simulation_results.mat',"simulation_results", 'v_grid', 'tl_grid');

%%
load('simulation_results.mat')
dataset = table();

for k = 1:length(simulation_results)
    current_signal = simulation_results(k).logsout{1}.Values;
    speed_signal = simulation_results(k).logsout{2}.Values;

    time = current_signal.Time;
    current = current_signal.Data;
    speed = speed_signal.Data;

    number_of_samples = length(time);

    simulation_table = table(repmat(v_grid(k), number_of_samples, 1), ... 
        repmat(tl_grid(k), number_of_samples, 1), time, current, speed, ...
        'VariableNames', {'Voltage', 'Load Torque', 'Time', 'Current', 'Speed'});
    dataset = [dataset; simulation_table];
end

%%
writetable(dataset, fullfile('..', 'data', 'motor_dataset.csv'))