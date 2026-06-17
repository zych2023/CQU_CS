"""实验一：基于简单天气 HMM 的 Viterbi 算法实现。

本脚本手写实现 Viterbi 算法（不依赖外部 HMM 库），
并对给定观测序列预测最可能的隐状态（天气）序列。
"""

from __future__ import annotations


def viterbi(states, observations, pi, transition, emission):
    """执行 Viterbi 算法，返回 (best_path, best_prob, delta, psi)。"""
    t_len = len(observations)

    # delta[t][s] 表示时刻 t 到达状态 s 的最优路径概率
    delta = [{s: 0.0 for s in states} for _ in range(t_len)]
    # psi[t][s] 记录时刻 t 到达状态 s 时对应的最优前驱状态
    psi = [{s: None for s in states} for _ in range(t_len)]

    # 初始化（t = 0）
    first_obs = observations[0]
    for s in states:
        delta[0][s] = pi[s] * emission[s][first_obs]
        psi[0][s] = None

    # 递推（t = 1..T-1）
    for t in range(1, t_len):
        obs_t = observations[t]
        for cur_state in states:
            best_prev_state = None
            best_prob = -1.0
            for prev_state in states:
                prob = (
                    delta[t - 1][prev_state]
                    * transition[prev_state][cur_state]
                    * emission[cur_state][obs_t]
                )
                if prob > best_prob:
                    best_prob = prob
                    best_prev_state = prev_state
            delta[t][cur_state] = best_prob
            psi[t][cur_state] = best_prev_state

    # 终止：选择最后时刻概率最大的状态
    final_state = max(states, key=lambda s: delta[t_len - 1][s])
    best_prob = delta[t_len - 1][final_state]

    # 回溯：根据 psi 反推整条最优路径
    best_path = [None] * t_len
    best_path[t_len - 1] = final_state
    for t in range(t_len - 2, -1, -1):
        best_path[t] = psi[t + 1][best_path[t + 1]]

    return best_path, best_prob, delta, psi


def print_result(seq_name, observations, best_path, best_prob, delta):
    print("=" * 72)
    print(f"{seq_name}")
    print(f"Observations: {observations}")
    print(f"Best weather path: {best_path}")
    print(f"Best path probability: {best_prob:.10f}")
    print("Delta values by time step:")
    for t, obs in enumerate(observations):
        print(
            f"  t={t}, obs={obs:>5} -> "
            f"delta[Sunny]={delta[t]['Sunny']:.10f}, "
            f"delta[Rainy]={delta[t]['Rainy']:.10f}"
        )
    print()


def main():
    states = ["Sunny", "Rainy"]

    pi = {"Sunny": 0.6, "Rainy": 0.4}

    transition = {
        "Sunny": {"Sunny": 0.8, "Rainy": 0.2},
        "Rainy": {"Sunny": 0.4, "Rainy": 0.6},
    }

    emission = {
        "Sunny": {"walk": 0.6, "shop": 0.3, "clean": 0.1},
        "Rainy": {"walk": 0.1, "shop": 0.4, "clean": 0.5},
    }

    observation_sets = {
        "Sequence 1": ["walk", "shop", "clean"],
        "Sequence 2": ["clean", "shop", "shop", "walk"],
        "Sequence 3": ["shop", "clean", "shop", "walk"],
    }

    for seq_name, observations in observation_sets.items():
        best_path, best_prob, delta, _ = viterbi(
            states, observations, pi, transition, emission
        )
        print_result(seq_name, observations, best_path, best_prob, delta)


if __name__ == "__main__":
    main()
