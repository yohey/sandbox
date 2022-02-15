#!/usr/bin/env python3
# -*- coding: utf-8 -*-


HOMEBREW_PREFIX = '/opt/homebrew' # '/usr/local'


def test_externalmedia(ax, T, p, pLabels):
    import os
    os.environ['OPENMODELICAHOME'] = os.path.join(HOMEBREW_PREFIX, 'opt/openmodelica@1.18')
    os.environ['OPENMODELICALIBRARY'] = ':'.join([os.path.join(HOMEBREW_PREFIX, 'opt/omlib-externalmedia/lib/omlibrary'),
                                                  os.path.join(os.environ['OPENMODELICAHOME'], 'lib/omlibrary'),
                                                  os.path.join(os.environ['HOME'], '.openmodelica/libraries')])

    from OMPython import ModelicaSystem

    mod = ModelicaSystem('TestCoolProp.mo', 'TestCoolProp.TestHydrogen', [('Modelica', '3.2.3'), 'ExternalMedia'])

    with open(mod.modelName + '.log', 'r') as fp:
        log = fp.read()

    if 'library not found for -lopenblas' in log:
        mod.sendExpression('setLinkerFlags("-L/opt/homebrew/opt/openblas/lib")')
        mod.buildModel()

    N = len(T) - 1
    mod.setSimulationOptions([f'stopTime = {N}', 'stepSize = 1'])

    for pValue, pLabel in zip(p, pLabels):
        mod.setParameters([f'pressure.duration = {N}',
                           f'pressure.offset = {pValue}',
                           'pressure.height = 0',
                           f'temperature.duration = {N}',
                           f'temperature.offset = {T[0]}',
                           f'temperature.height = {T[-1]-T[0]}'])

        mod.simulate()

        ax.plot(mod.getSolutions('s')[0] * 1e-3, mod.getSolutions('h')[0] * 1e-3, label=pLabel)


def test_coolprop(ax, T, p, pLabels):
    from CoolProp import CoolProp as CP

    for pValue, pLabel in zip(p, pLabels):
        h = CP.PropsSI('H', 'P', pValue, 'T', T, 'Hydrogen')
        s = CP.PropsSI('S', 'P', pValue, 'T', T, 'Hydrogen')

        ax.plot(s * 1e-3, h * 1e-3, label=pLabel)



if __name__ == '__main__':
    import numpy as np
    from matplotlib import pyplot as plt

    T = np.linspace(20, 2000, 101)
    p = [1e3, 1e4, 1e5, 1e6, 1e7, 1e8]
    pLabels = ['1 [kPa]', '10 [kPa]', '100 [kPa]', '1 [MPa]', '10 [MPa]', '100 [MPa]']

    fig, ax = plt.subplots()
    test_externalmedia(ax, T, p, pLabels)
    ax.set_xlabel('Entropy    s    [kJ/(kg*K)]')
    ax.set_ylabel('Enthalpy    h    [kJ/kg]')
    ax.legend()
    ax.set_title('Test (OpenModelica + ExternalMedia)')
    plt.show()

    fig, ax = plt.subplots()
    test_coolprop(ax, T, p, pLabels)
    ax.set_xlabel('Entropy    s    [kJ/(kg*K)]')
    ax.set_ylabel('Enthalpy    h    [kJ/kg]')
    ax.legend()
    ax.set_title('Test (Python + CoolProp)')
    plt.show()
